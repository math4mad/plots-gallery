using GLMakie,DataFrames,LinearAlgebra
using Distributions 
d=Normal(0.1,0.2)
fig = Figure()
ax = Axis3(fig[1, 1];azimuth=-0.1pi,elevation=-0.05pi)
function plot_sphere(r)
    θ = LinRange(0, π, 16)
    φ = LinRange(-π, π, 2 * 16)
    xs = [r * cos(φ) * sin(θ) for θ in θ, φ in φ]
    ys = [r * sin(φ) * sin(θ) for θ in θ, φ in φ]
    zs = [r * cos(θ) for θ in θ, φ in φ]
    scatter!(ax,xs,ys,zs,color=(:lightgreen),markersize=4,strokewidth=0.5,strokecolor=:black)
end



data=DataFrame(xs=Float64[],ys=Float64[],zs=Float64[])

function make_sphere_data(r)
    θ = LinRange(0, π, 16)
    φ = LinRange(-π, π, 2 * 16)
    xs = [r * cos(φ) * sin(θ) for θ in θ for φ in φ]
    ys = [r * sin(φ) * sin(θ) for θ in θ for  φ in φ]
    zs = [r * cos(θ) for θ in θ for  φ in φ]
    xs=xs+rand(d,512)
    ys=ys+rand(d,512)
    zs=zs+rand(d,512)
    #scatter!(ax,xs,ys,zs)
    # xs=xs[1],ys=ys[1],zs=zs[1]
    df=DataFrame(xs=xs,ys=ys,zs=zs)
    return df
    
end

radius_range=range(1,5,20)

for r in  radius_range
   df= make_sphere_data(r)
   global data=vcat(data,df)
end

scatter!(ax,eachcol(data)...,marker='o')
fig
#save("sphere-shape-randomdata.png",fig)