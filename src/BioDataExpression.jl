module BioDataExpression

  using SQLite
  using Missings
  using StatsBase
  using MultivariateStats
  
  export SingleCellExpr, BioData, Normalize, Zscore, Log
  
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
  include("BioData/Log.jl")
  include("BioData/Show.jl")
    
end # module
