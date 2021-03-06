"Normalize( data::SingleCellExpr, reads::Int64 )

Normalize Single Cell Data the hard way - resampling

This will add/update the samples column ResampleN where it will store the 
final re-scale value used to obtain the total amount of requested reads in the sample.
Lets see - possibly this value will be of use later on.

This function will add -1 values for all sample/gene touples that had a value in the raw data, 
but were set to 0 due to the resampling.
"
function Normalize( data::SingleCellExpr, reads::Int64 ) 
  
  if (typeof(data.raw) != Int64)
    println( "The data has been normalized before - reverting to raw data") 
    data.data = data.raw
    data.raw = 0
    data.zscored=0
  end
  
  println(string("the data will be re-sampled to ", reads, " reads"))
    
  f = function(x)
    sum(nonzeros(x))
  end
  csum = mapslices( f, data.data, 1)
  
  nm = length( nonzeros(data.data) )
  pos = 0
  #define max result values
  v = zeros(nm)
  r = zeros(nm)
  c = zeros(nm)
  ns = zeros(size(data.data)[2]) 
  for i = 1:size(data.data)[2]
    n = reads
    p = data.data[1:size(data.data)[1],i] / csum[i]
    if  sum(map(round, p*reads)) > reads 
       while  sum(map(round, p*n)) > reads
         n -= 1
       end
    elseif sum(map(round, p*reads)) < reads 
       while  sum(map(round, p*n)) < reads
         n += 1
       end
    end
    val = map(round, p*n)
    ns[i] = n
    ## now I likely have lost values
    ## which I want to set to -1
    t = countmap(vcat(p.nzind, val.nzind))
    bad = collect(keys(t))[find(collect(values(t)) .== 1)]
    ## collect the Int64 > 0 values
    ok = (pos+1):(pos+length(val.nzind)+length(bad))
    v[ok] = vcat(collect(val.nzval), fill( -1, length(bad) ) )
    r[ok] = vcat(val.nzind, bad)
    c[ok] = fill(i, length(val.nzind) + length(bad))
    pos = pos+length(val.nzind)+ length(bad)
  end
  data.raw = data.data
  data.data = sparse( r[1:pos], c[1:pos] , v[1:pos] )
  data.samples[:ResampleN] = ns
  #= build the new sparse matrix =#
return (data)
end



