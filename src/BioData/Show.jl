function Base.show(io::IO, m::SingleCellExpr ) 
  println(string( "And object of class " , typeof( data) , " with " , size( data.data)[2], " Cells and ", size(data.data)[1] , " Genes" )  )
  if ( typeof(data.raw) != Int64 )
    println(string( "The data has been normalized" ))
  end
  if ( typeof(data.zscored) != Int64 )
    println(string( "The data has been z-scored" ))
  end
end