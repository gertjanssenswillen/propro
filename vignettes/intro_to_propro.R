## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
collapse = TRUE,
comment = "#>",
warning = FALSE
)

## ----warning = F, message = F--------------------------------------------
library(propro)
library(bupaR)
library(petrinetR)

## ---- fig.width = 7------------------------------------------------------
log <- log_2_paper_ICPM
log %>%
    trace_explorer(coverage = 1)

## ---- fig.width = 7------------------------------------------------------
net <- model_2_paper_ICPM
net$final_marking <- "p8"
render_PN(net)

## ------------------------------------------------------------------------
create_propro(log, net) -> propro

## ------------------------------------------------------------------------
print_propro(propro)

## ---- fig.width = 7------------------------------------------------------
plot_automaton(propro)

## ------------------------------------------------------------------------
propro %>%
    set_prior_complements(n = 2) %>%
    list_priors()

## ------------------------------------------------------------------------
propro %>%
    set_prior_complements(n = 2) %>%
    set_prior("beta[12]", "<- beta[3]")%>%
    set_prior("beta[10]", "<- beta[5]")%>%
    set_prior("beta[14]", "<- beta[5]")%>%
    set_prior("beta[19]", "<- beta[5]")%>%
    set_prior("beta[17]", "<- beta[8]")%>%
    set_prior("beta[16]", "<- beta[7]")%>%
    set_prior("beta[18]", "<- beta[9]") %>%
    list_priors



## ------------------------------------------------------------------------
propro %>%
    set_prior_complements(n = 2) %>%
    set_prior("beta[12]", "<- beta[3]")%>%
    set_prior("beta[10]", "<- beta[5]")%>%
    set_prior("beta[14]", "<- beta[5]")%>%
    set_prior("beta[19]", "<- beta[5]")%>%
    set_prior("beta[17]", "<- beta[8]")%>%
    set_prior("beta[16]", "<- beta[7]")%>%
    set_prior("beta[18]", "<- beta[9]") %>%
    combine_consecutive_priors(start = 7, end = 9) %>%
    set_prior("beta[7:9]", "<- ddirich(alpha[1:3])") %>%
    add_data("alpha", c(1,1,1)) %>%
    list_priors

## ------------------------------------------------------------------------
propro %>%
    set_prior_complements(n = 2) %>%
    set_prior("beta[12]", "<- beta[3]")%>%
    set_prior("beta[10]", "<- beta[5]")%>%
    set_prior("beta[14]", "<- beta[5]")%>%
    set_prior("beta[19]", "<- beta[5]")%>%
    set_prior("beta[17]", "<- beta[8]")%>%
    set_prior("beta[16]", "<- beta[7]")%>%
    set_prior("beta[18]", "<- beta[9]") %>%
    combine_consecutive_priors(start = 7, end = 9) %>%
    set_prior("beta[7:9]", "~ddirich(alpha[1:3])") %>%
    add_data("alpha", c(1,1,1)) %>%
    set_prior("beta[1]", "~dbeta(1,1)")%>%
    set_prior("beta[3]", "~dbeta(1,1)")%>%
    set_prior("beta[5]", "~dbeta(1,1)")%>%
    set_prior("beta_f", "~dbeta(1,1)") %>%
    list_priors()

## ------------------------------------------------------------------------
propro %>%
    set_prior_complements(n = 2) %>%
    set_prior("beta[12]", "<- beta[3]")%>%
    set_prior("beta[10]", "<- beta[5]")%>%
    set_prior("beta[14]", "<- beta[5]")%>%
    set_prior("beta[19]", "<- beta[5]")%>%
    set_prior("beta[17]", "<- beta[8]")%>%
    set_prior("beta[16]", "<- beta[7]")%>%
    set_prior("beta[18]", "<- beta[9]") %>%
    combine_consecutive_priors(start = 7, end = 9) %>%
    set_prior("beta[7:9]", "~ddirich(alpha[1:3])") %>%
    add_data("alpha", c(1,1,1)) %>%
    set_prior("beta[1]", "~dbeta(1,1)")%>%
    set_prior("beta[3]", "~dbeta(1,1)")%>%
    set_prior("beta[5]", "~dbeta(1,1)")%>%
    set_prior("beta_f", "~dbeta(1,1)") %>%
    add_variable("delta[1]", "<- beta[5] - beta[9]") -> propro 

## ------------------------------------------------------------------------
propro %>%
    print_propro()

## ----message = F---------------------------------------------------------
propro %>%
    write_propro("propro_model2.txt") %>%
    run_propro(n.chains = 2, n.iter = 40000, n.burnin = 1000)

