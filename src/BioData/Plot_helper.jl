
"covert a sparse vector into a normal vector"
function toPlot( x::SparseVector )
  ret = zeros( x.n ) 
  ret[x.nzind] = x.nzval
  return (ret)
end
