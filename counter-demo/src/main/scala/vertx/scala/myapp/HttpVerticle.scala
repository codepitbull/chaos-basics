package vertx.scala.myapp

import io.vertx.lang.scala.ScalaVerticle
import io.vertx.scala.ext.web.Router

import scala.concurrent.Future
import scala.util.{Failure, Success}

class HttpVerticle extends ScalaVerticle {

  override def startFuture(): Future[_] = {
    vertx
      .sharedData()
      .getCounterFuture("requestCounter")
      .map(counter => {
        val router = Router.router(vertx)
        router.get("/count").handler(req => {
            counter.incrementAndGetFuture()
            req.response().end("counted")
          })
        router.get("/value").handler(req => counter.getFuture().onComplete{
          case Success(value) =>  req.response().end(value.toString)
          case Failure(t)     =>  req.fail(t)
        })

        vertx
          .createHttpServer()
          .requestHandler(router.accept _)
          .listenFuture(8666, "0.0.0.0")
      })
  }
}
