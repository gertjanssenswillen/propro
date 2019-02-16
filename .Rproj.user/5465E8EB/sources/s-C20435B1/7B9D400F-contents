

#' Run propro model
#'
#' @param propro_model A propro model
#' @param n.chains Number of chains (see R2jags)
#' @param n.iter  Number of iterations (see R2jargs)
#' @param n.burnin Burn in (see R2jags)
#' @param ... Other arugements for R2jags
#'
#' @export
#'
run_propro <- function(propro_model, n.chains, n.iter, n.burnin, ...) {

    jags(data = propro_model$data,
         inits = NULL,
         parameters.to.save = propro_model$params,
         n.chains = n.chains,
         n.iter = n.iter,
         n.burnin = n.burnin,
         model.file = propro_model$file,
         ...)
}
