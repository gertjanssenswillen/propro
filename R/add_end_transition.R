


add_end_transition <- function(PN, final_marking) {

    PN %>%
        add_places("end_place") %>%
        add_transitions("End") %>%
        add_flows(data_frame(from = c(final_marking,"End"), to = c("End","end_place")))  -> PN

    return(PN)
}


PARSE <- function(PN, trace) {
    if(!is.list(PN)) {
        if(PN == F)
            return(F)
    }
    else
        petrinetR::parse(PN, trace)
}
MARKING <- function(PN) {
    if(!is.list(PN)) {
        if(PN == F)
            return(F)
    }
    else
        petrinetR::marking(PN)
}
check_fitting <- function(eventlog, PN) {

    trace_vector <- NULL
    is_fitting <- NULL


    end_marking <- PN$final_marking
    net <- PN
    eventlog %>%
        trace_list %>%
        mutate(trace_vector = str_split(trace, ",")) %>%
        mutate(is_fitting = map_lgl(trace_vector, ~parsel(net, .x))) -> list_of_traces

    list_of_traces %>%
        mutate(if_fitting = ifelse(is_fitting, map_lgl(trace_vector, ~ MARKING(PARSE(net, .x)) == "end_place"), FALSE)) -> list_of_traces

    eventlog %>%
        case_list %>%
        inner_join(list_of_traces) %>%
        filter(is_fitting) %>%
        pull(case_id) -> fitting_case_ids

    eventlog %>%
        mutate(is_fitting = case_id %in% fitting_case_ids)
}
