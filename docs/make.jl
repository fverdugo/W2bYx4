using W2bYx4
using Documenter

command_jup = "jupyter"
command_nbc = "nbconvert"
output_format = "--to=html"
theme = "--theme=dark"
output = "--output=index"
output_dir = "--output-dir=docs/src/notebook-output"
infile = "docs/src/notebook.ipynb"
run(`$command_jup $command_nbc $output_format $output $output_dir $theme $infile`)


makedocs(;
    modules=[W2bYx4],
    authors="Francesc Verdugo <f.verdugo.rojano@vu.nl>",
    repo="https://github.com/fverdugo/W2bYx4/blob/{commit}{path}#{line}",
    sitename="W2bYx4",
    format=Documenter.HTML(;
        assets = ["assets/custom.css"],
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://fverdugo.github.io/W2bYx4",
        edit_link="main",),
    pages=["Home" => "index.md","Notebooks"=>["Notebook 1"=>"notebook.md", "Notebook 2"=>"notebook-2.md"]],
)

deploydocs(;
    repo="github.com/fverdugo/W2bYx4",
    devbranch="main",
)
