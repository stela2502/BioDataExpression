"Z score a single cell data set

The data will be centered around +10 to make use of the sparse matrix data compression
Not expressed gene/cell combination will get the 0 value and genes lost in the normalization process will get a -1
"
function Zscore(data::SingleCellExpr)
  function scale(v::SparseVector)
    z = copy(v)
    z[z.nzind] = 10 + z[v.nzind] -mean(z[z.nzind]) / std(z[z.nzind])
    return(z)
  end
  function zScore(x::SparseVector)
    ##n = find(x .>= 0) ## there are no 0 vals ;-)
    if (length(find(x .== -1)) == 0 )
      x =   scale(x)
    else 
      ok = find(x .>= 0)
      x[ok] = scale(x[ok])
    end
    return x
  end
  ## now I need to dig through the data in row direction (bad)
  nm = length( nonzeros(data.data) )
  pos = 0
  #define max result values
  v = zeros(nm)
  r = zeros(nm)
  c = zeros(nm)
  cells = size(data.data)[2]
  for i =1:size(data.data)[1] 
    val = zScore( data.data[i,1:cells] );
    ## collect the Int64 > 0 values
    ok = (pos+1):(pos+length(val.nzind));
    v[ok] = collect(val.nzval);
    c[ok] = val.nzind;
    r[ok] = fill(i, length(val.nzind));
    pos = pos+length(val.nzind);
  end
  data.zscored = sparse( r[1:pos], c[1:pos] , v[1:pos] )
  
  return data
end