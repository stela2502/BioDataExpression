

function Base.show(io::IO, m::SingleCellExpr ) 
  println(string( "And object of class " , typeof( m) , " with " , size( m.m)[2], " Cells and ", size(m.m)[1] , " Genes" )  )
  if ( typeof(m.raw) != Int64 )
    println(string( "The data has been normalized" ))
  end
  if ( typeof(m.zscored) != Int64 )
    println(string( "The data has been z-scored" ))
  end
end