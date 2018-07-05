module BioDataExpression

  using SQLite
  using StatsBase
  
  export SingleCellExpr, BioData
  
  #= 
  println("the comment has not worked!")
  basePath = dirname(dirname(Base.functionloc(BioDataExpression.eval, Tuple{Void})[1]))
  include(joinpath(basePath,"src","BioData/Constructors.jl"))
  include(joinpath(basePath,"src","BioData/Normalize.jl"))
  include(joinpath(basePath,"src","BioData/Zscore.jl"))
  include(joinpath(basePath,"src","BioData","Show.jl"))
  =#

  include("BioData/Constructors.jl")
  include("BioData/Normalize.jl")
  include("BioData/Zscore.jl")
  include("BioData/Show.jl")
    
end # module
