using GeoMakie, CairoMakie
projections = ["+proj=adams_ws2",
"+proj=aea +lat_1=29.5 +lat_2=42.5", "+proj=aeqd", "+proj=airy", "+proj=aitoff",
"+proj=apian", "+proj=august", "+proj=bacon", "+proj=bertin1953", "+proj=bipc +ns",
"+proj=boggs", "+proj=bonne +lat_1=10", "+proj=cass", "+proj=cea","+proj=chamb +lat_1=10 +lon_1=30 +lon_2=40", "+proj=collg", "+proj=comill"]

    fig = Figure(size=(1500, 1500))
    for (idx, projection) in enumerate(projections)
        ga = GeoAxis(
            fig[fldmod1(idx,4)...];
            aspect=nothing,
            dest=projection,
            title="$(projection)"
        )
        lines!(ga, GeoMakie.coastlines())
    end
    fig
