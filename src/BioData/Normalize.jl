"Normalize Single Cell Data the hard way - resampling"
function normalize( data::SingleCellExpr, reads::Int64 ) {
 f = function(x) 
   sum(nonzeros(x))
 end
 csum = mapslices( f, data.data, 1)
 for i = 1:size(data.data)[2]
   n = reads
   p = data.data[1:size(data.data)[1],i] / csum[i]
   if  sum(map(round, p*reads)) > reads 
      while  sum(map(round, p*n)) > reads
        n -= 1
      end
   else if sum(map(round, p*reads)) < reads 
      while  sum(map(round, p*n)) < reads
        n+=1
      end
   end
   p = map(round, p*n)
   ## collect the Int64 > 0 values
   
 end

 #= build the new sparse matrix =#
 
}
