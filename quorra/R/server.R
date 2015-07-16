#
#
# Web server for hosting quorra plots.
#
# @author <bprinty@gmail.com>
# ------------------------------------------


#' Global variable to manage page visit counts.
quorra.iter <- 0


#' Start server running on specified port.
#'
#' @param host Host name of running server.
#' @param port Port number ro run on.
#' @return Rook server object.
quorra.server = function(host='localhost', port=8080){
    require(Rook)

    # init app and add data directory
    server <- Rhttpd$new()
    server$add(app=File$new(getwd()), name="data")

    # create and add rook app
    app <- function(env){
    	quorra.iter <<- quorra.iter + 1

	# set up request/response handling
	request <- Request$new(env)
	response <- Response$new()

	# write html

	# finish response
	response$finish()
    }
    server$add(app=app, name="Quorra")
    server
}

