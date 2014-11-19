## bugs in v0.3 and compatibility
if VERSION < v"0.4.0-dev"
    Base.copy{T,A,uplo}(t::Triangular{T,A,uplo}) = Triangular(copy(t.data), uplo)
end

## this we need for xμTΛxμ!
Base.A_mul_Bc!(A::StridedMatrix{Float64}, B::Triangular{Float32}) = A_mul_Bc!(A, convert(AbstractMatrix{Float64}, B))
Base.A_mul_Bc!(A::Matrix{Float32}, B::Triangular{Float64}) = A_mul_Bc!(A, convert(AbstractMatrix{Float32}, B))
## this for diagstats
Base.BLAS.gemm!(a::Char, b::Char, alpha::Float64, A::Matrix{Float32}, B::Matrix{Float64}, beta::Float64, C::Matrix{Float64}) = Base.BLAS.gemm!(a, b, alpha, float64(A), B, beta, C)
