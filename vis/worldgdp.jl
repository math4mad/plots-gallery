using Makie, CairoMakie, GeoMakie
import Downloads
using GeoMakie.GeoJSON
using GeometryBasics
using GeoMakie.GeoInterface
using CSV,DataFrames, Tidier,Pipe
using StatsBase
path="./vis/data/countries.geojson"
json_str = read(path, String)
worldCountries = GeoJSON.read(json_str)
n = length(worldCountries)

df=@pipe CSV.File("./vis/data/gdp-per-capita-penn-world-table.csv")|>DataFrame|>transform(_,"GDP per capita (output, multiple price benchmarks)"=>"gdp")|>select(_,Not("GDP per capita (output, multiple price benchmarks)"))
ys=2019
df=@chain df begin
   @clean_names
   @filter(year== !!ys)
   @rename(ISO_A3=code)
   #@mutate(gdp=zscore([gdp...]))
end
geo_df = @chain DataFrame(worldCountries) @select(ISO_A3)

df=@left_join(geo_df, df,"ISO_A3")
df.gdp=@pipe df.gdp|>coalesce.(_, 0)
lons = -180:180
lats = -90:90
field = [exp(cosd(l)) + 3(y/90) for l in lons, y in lats]
n,_=size(df)

function plot_map()
    fig = Figure(size = (200,200), fontsize = 16)

ax = GeoAxis(
    fig[1,1];
    dest="+proj=eqc",
    title = "World GDP",
    tellheight = true,
)

# hm1 = surface!(ax, lons, lats, field)
# translate!(hm1, 0, 0, -10)

hm2 = poly!(
    ax, worldCountries;
    color=df.gdp,
    colormap = Reverse(:plasma),
    strokecolor = :black,
    strokewidth = 0.25
)
cb = Colorbar(fig[1,2]; colorrange = (1, n), colormap = Reverse(:plasma), label = "variable, color code", height = Relative(0.65))
fig
end
plot_map()

