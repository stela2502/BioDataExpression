"Log( data::SingleCellExpr )

Log the expression data using log(x+1), not log2 or log10
This will not touch the 0 or -1 values

"

function Log( data::SingleCellExpr )
  function logthis(x::SparseVector)
    ok = find( x .> 0 );
    x[ok] .= log(x[ok]+1);
    return x
  end
  rws = 1:size(data.data)[1]
  for  i =  1:size(data.data)[2]
    data.data[rws,i] = logthis( data.data[rws,i] )
  end
  return data
end