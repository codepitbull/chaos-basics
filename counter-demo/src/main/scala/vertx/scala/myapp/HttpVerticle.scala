package vertx.scala.myapp

import io.vertx.lang.scala.ScalaVerticle
import io.vertx.scala.ext.web.Router

import scala.concurrent.Future
import scala.util.{Failure, Success}

class HttpVerticle extends ScalaVerticle {

  override def startFuture(): Future[_] = {

    val host = config.getString("host")

    val client = vertx.createHttpClient()

    var local_counter = 0

    vertx
      .sharedData()
      .getCounterFuture("requestCounter")
      .map(counter => {
        val router = Router.router(vertx)

        router.get("/count_distributed").handler(req => {
            counter.incrementAndGetFuture()
            req.response().end("counted")
          })


        router.get("/count_from_other").handler(req => {
          local_counter = local_counter + 1
          req.response().end("counted")
        })

        router.get("/count_http").handler(req => {
            req.response().end("counted")
            client.get(8666, host, "/count_from_other").handler(resp => ()).end()
          })

        router.get("/value_distributed").handler(req => counter.getFuture().onComplete{
          case Success(value) =>  req.response().end(value.toString)
          case Failure(t)     =>  req.fail(t)
        })

        router.get("/value_local").handler(req => req.response().end(local_counter.toString))

        vertx
          .createHttpServer()
          .requestHandler(router.accept _)
          .listenFuture(8666, "0.0.0.0")
      })
  }
}
