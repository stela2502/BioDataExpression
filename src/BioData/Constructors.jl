

"The most basic constructor"
mutable struct SingleCellExpr
    data::SparseMatrixCSC
    samples::DataFrame
    annotation::DataFrame
    name::String
    raw::Any
    zscored::Any
    outpath::String
end


"Read the data from a cellexalvrR database"
function BioData( file::String )
      if ! isfile(file)
        throw(ArgumentError("database file does not exists"))
      end
      
      db = SQLite.DB(file)
      so = SQLite.query(db, "SELECT  gene_id, cell_id, value from datavalues")
      #println(so)
      if typeof(so[2]) == DataType(Array{Union{Int64, Missings.Missing},1}) 
        A = sparse( so[1], so[2], so[3] );
      else
        A = sparse( map( Int64,collect(so[1]) ),  map(Int64,collect(so[2])) , map( Int64, collect(so[3]))  )
      end
      samples = SQLite.query(db, "SELECT * from cells")
      #println(samples)
      annotation = SQLite.query(db, "SELECT * from genes")
      #println(annotation)
      return ( SingleCellExpr( A, samples, annotation, "Unnamed SingleCellData", 0 , 0, pwd() ) )
end


