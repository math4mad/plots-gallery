using CairoMakie,CSV,DataFrames,Pipe,Tidier,HypertextLiteral
using MakieThemes
using StatsBase
using AlgebraOfGraphics
using RCall
using ScientificTypes
#Makie.set_theme!(ggthemr(:dust))


function make_title(str::String)
    return @htl("""
    <div class="alert alert-primary" role="alert">
       $(str)
    </div>
""")
end
@info "loading success"