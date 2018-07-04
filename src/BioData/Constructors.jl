
"The most basic constructor"
mutable struct SingleCellExpr
    data::SparseMatrixCSC
    samples::DataFrame
    annotation::DataFrame
    name::String
    raw::Any
    zscored::Any
end


"Read the data from a cellexalvrR database"
function BioData( file::String )
      db = SQLite.DB(file)
      so = SQLite.query(db, "SELECT * from datavalues")
      if typeof(so[2]) == DataType(Array{Union{Int64, Missings.Missing},1}) 
        A = sparse( so[1], so[2], so[3] );
      else
        A = sparse( map( Int64,collect(so[1]) ),  map(Int64,collect(so[2])) , map( Int64, collect(so[3]))  )
      end
      samples = SQLite.query(db, "SELECT * from cells")
      annotation = SQLite.query(db, "SELECT * from genes")
      
      return ( SingleCellExpr( A, samples, annotation, "Unnamed SingleCellData", 0 , 0 ) )
end

function Base.show(io::IO, m::SingleCellExpr ) 
  println(string( "And object of class " , typeof( data) , " with " , size( data.data)[2], " Cells and ", size(data.data)[1] , " Genes" )  )
  if ( typeof(data.raw) != Int64 )
    println(string( "The data has been normalized" ))
  end
  if ( typeof(data.zscored) != Int64 )
    println(string( "The data has been z-scored" ))
  end
end
