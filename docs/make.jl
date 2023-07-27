using W2bYx4
using Documenter

function modify_notebook_html( html_name )
    content = open( html_name, "r" ) do html_file 
        read( html_file, String )
    end
    content_new = replace(content, 
        r"(<script\b[^>]*>[\s\S]*?<\/script>\K)" => 
        s"\1\n\t<script src='../assets/iframeResizer.contentWindow.min.js'></script>\n";
        count = 1
    )
    open( html_name, "w" ) do html_file
        write( html_file, content_new )
    end
    return nothing
end

# Convert to html
function convert_notebook_to_html(notebook_path; output_name = "index", output_dir = "docs/src/notebook-output", theme = "dark")
    command_jup = "jupyter"
    command_nbc = "nbconvert"
    output_format = "--to=html"
    theme = "--theme=$theme"
    output = "--output=$output_name"
    output_dir = "--output-dir=$output_dir"
    infile = notebook_path
    run(`$command_jup $command_nbc $output_format $output $output_dir $theme $infile`)
end

convert_notebook_to_html("docs/src/notebook.ipynb")
# Modify html (resize iframe)
modify_notebook_html("docs/src/notebook-output/index.html")

makedocs(;
    modules=[W2bYx4],
    authors="Francesc Verdugo <f.verdugo.rojano@vu.nl>",
    repo="https://github.com/fverdugo/W2bYx4/blob/{commit}{path}#{line}",
    sitename="W2bYx4",
    format=Documenter.HTML(;
        assets = ["assets/iframeResizer.min.js"],
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://fverdugo.github.io/W2bYx4",
        edit_link="main",),
    pages=["Home" => "index.md","Notebooks"=>["Notebook 1"=>"notebook.md", "Notebook 2"=>"notebook-2.md"]],
)

deploydocs(;
    repo="github.com/fverdugo/W2bYx4",
    devbranch="main",
)
