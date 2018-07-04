module BioDataExpression

  using SQLite, StatsBase
  
  include("BioData/Constructors.jl")
  include("BioData/Normalize.jl")
  include("BioData/PlotHelper.jl")
  include("BioData/Zscore.jl")
  

end # module
