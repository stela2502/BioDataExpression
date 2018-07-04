using BioDataExpression
@static if VERSION < v"0.7.0-DEV.2005"
    using Base.Test
else
    using Test
end

# write your own tests here
@test 1 == 1

dbfile = joinpath(pwd(),"test", "data","database.sqlite");

@test isfile(dbfile)

data = BioData( dbfile );

@test length( nonzeros(data.data) ) == 97784

Normalize(data, 100)

@test length( nonzeros(data.raw) ) == 97784

@test length( nonzeros(data.data) ) == 77660

@test corspearman( log(toPlot( data.data[1:100,1])+1),log10(toPlot(data.raw[1:100,1])+1) ) > 0.9

res = zersos( size(data.data)[2] )
for i=1:size(data.data)[2]
  res[i] = corspearman( log(toPlot( data.data[1:100,i])+1),log10(toPlot(data.raw[1:100,i])+1) ) > 0.8
end

@test length(find(res .== 0)) == 0
  

Zscore(data)

@test length( nonzeros(data.zscored) ) == 77660

@test corspearman( log(toPlot( data.data[1:100,1])+1),log10(toPlot(data.zscored[1:100,1])+1) ) > 0.9

res = zersos( size(data.data)[2] )
for i=1:size(data.data)[2]
  res[i] = corspearman( log(toPlot( data.data[1:100,i])+1),log10(toPlot(data.zscored[1:100,i])+1) ) > 0.8
end

@test length(find(res .== 0)) == 0

