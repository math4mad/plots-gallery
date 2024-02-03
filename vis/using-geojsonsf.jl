using Makie, CairoMakie, GeoMakie
import Downloads
using GeoMakie.GeoJSON
using GeometryBasics
using GeoMakie.GeoInterface
using CSV,DataFrames, Tidier,Pipe
using StatsBase
using RCall   
path="./vis/data/countries.geojson"
json_str = read(path, String)
worldCountries = GeoJSON.read(json_str)
n = length(worldCountries)


# R"""
# path="/Users/lunarcheung/Public/JuliaCode/JuliaProject/plots-gallery/vis/data/countries.geojson"
# library(geojsonio)
# library(geojsonsf)
# spdf <- geojson_read(path,  what = "sp")
# sf <- geojson_sf(spdf)
# """

R"""
library(mapsf)
library(sf)
mtq<-st_read("/Users/lunarcheung/Downloads/StatPlanet_China/map/map.shp")
mf_theme("darkula")
# plot a shadow
mf_shadow(mtq)
# plot municipalities
mf_map(mtq, add = TRUE)
# plot population
mf_map(
  x = mtq,
  var = "POP",
  type = "prop",
  inches = 0.25,
  col = "brown4",
  leg_pos = "topright",
  leg_adj = c(0, -2),
  leg_title = "Total population"
)
# layout
mf_layout(
  title = "Population Distribution in Martinique",
  credits = paste0(
    "Sources: Insee and IGN, 2018\n",
    "mapsf ",
    packageVersion("mapsf")
  )
)
"""