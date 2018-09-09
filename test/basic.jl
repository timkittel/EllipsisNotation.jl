
using EllipsisNotation
using Test
A = zeros(2,4,2)

@test size(A[..]) == (2,4,2)
A[..,1] = [2 1 4 5
           2 2 3 6]

A[..,2] = [3 2 6 5
          3 2 6 6]

@test A[:,:,1] == [2 1 4 5
                   2 2 3 6]

@test A[:,:,2] == [3 2 6 5
                   3 2 6 6]

A[1,..] = reshape([3 4
                   5 6
                   4 5
                   6 7],1,4,2)

B = [3 4
     5 6
     4 5
     6 7]

@test B == reshape(A[1,..],4,2) == reshape(view(A, 1,..), 4, 2)

@test A[:,1,2] == A[..,1,2] == @view A[..,1,2]

# testing [..]
C = similar(B)

C[:] = B[..]
@test B == C
@test B ≢ C
C[1,1] += 1
@test B != C

C[..] = B[..]
@test B == C
@test B ≢ C
C[1,1] += 1
@test B != C
