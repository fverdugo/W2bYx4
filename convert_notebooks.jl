command_jup = "jupyter"
command_nbc = "nbconvert"
output_format = "--to=html"
theme = "--theme=dark"
output = "--output=index"
output_dir = "--output-dir=notebook-output"
infile = "notebook.ipynb"
cd("docs/src")
run(`$command_jup $command_nbc $output_format $output $output_dir $theme $infile`)
cd("../..") 