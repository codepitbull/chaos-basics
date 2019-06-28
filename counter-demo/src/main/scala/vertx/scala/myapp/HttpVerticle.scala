package vertx.scala.myapp

import io.vertx.lang.scala.ScalaVerticle
import io.vertx.scala.core.http.HttpClientOptions
import io.vertx.scala.ext.web.Router

import scala.concurrent.Future

class HttpVerticle extends ScalaVerticle {

  override def startFuture(): Future[_] = {

    val host = config.getString("host")


    val refreshPage = "<html xmlns=\"http://www.w3.org/1999/xhtml\">" +
      "<head><meta http-equiv=\"refresh\" content=\"1\"/></head>" +
      "<body>req sent: {{req_sent}}<br/>req handled: {{req_handled}}<br/>rate: {{rate}}</body>" +
      "</html>"

    var outgoing_req_counter = 0
    var req_counter = 0

    var old_value = 0l
    var rate = 0l

    val router = Router.router(vertx)
    val clientOptions = HttpClientOptions()
      .setDefaultHost(host)
      .setDefaultPort(8666)
      .setConnectTimeout(100)

    val client = vertx.createHttpClient(clientOptions)

    router.get("/count_http").handler(req => {
      req_counter = req_counter + 1
      req.response().end("counted")
    })

    router.get("/status").handler(req => {
      val response = refreshPage
        .replace("{{req_sent}}", outgoing_req_counter.toString)
        .replace("{{req_handled}}", req_counter.toString)
        .replace("{{rate}}", rate.toString)
      req.response().headers().add("Content-Type", "application/xhtml+xml")
      req.response().end(response)
    })

    vertx.setPeriodic(100l, time => {
      outgoing_req_counter = outgoing_req_counter + 1
      client.get("/count_http").handler(resp => ()).setTimeout(100).exceptionHandler(t => println(t.getMessage)).end()
    })

    vertx.setPeriodic(1000l, time => {
      rate = req_counter - old_value
      old_value = req_counter
    })

    vertx
      .createHttpServer()
      .requestHandler(router.accept _)
      .listenFuture(8666, "0.0.0.0")
  }
}
