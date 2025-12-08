display_help = function(function_name, proj_dir) {

  #' @title Display the help for function.
  #'
  #' @description Takes the help file '*.Rd' for a function and displays it inline for rmd.
  #'
  #' @param funtion_name The name of the function, str

  #' @examples
  #' display_help("make_apa_str")
  #' display_help("display_help")

  #' @export
  #'

  rdfile = Rd2md::read_rdfile(paste0(proj_dir, '/', sprintf("/man/%s.Rd", function_name)))
  markdown_doc = Rd2md::as_markdown(rdfile)
  knittr::asis_output(markdown_doc)

}
