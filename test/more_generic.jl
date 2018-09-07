using EllipsisNotation
using Test
B = zeros(Int64, 2, 3, 4, 5, 6)

B[.., 2, 3, 5] .+= 1
n = 0
for i5=1:6, i4=1:5, i3=1:4
    global n
    n += 1
    B[.., i3, i4, i5] .= n
end
@test B[1, 1, ..] == B[1, 1, :, :, :] == reshape(1:120, 4, 5, 6)
@test B[1, 1, .., 1] == B[1, 1, :, :, 1] == reshape(1:20, 4, 5)

C = zeros(Int64, 2, 3, 4, 5, 6)

n = 0
for i3=1:4, i2=1:3, i1=1:2
    global n
    n += 1
    C[i1, i2, i3, ..] .= n
end
@test C[.., 1, 1] == C[:, :, :, 1, 1] == reshape(1:24, 2, 3, 4)
@test C[1, .., 1, 1] == C[1, :, :, 1, 1] == reshape(1:2:24, 3, 4)

D = ones(Int, 1, 2, 3, 4)
D[1, .., 2] .= 2
@test D == [i1 == 1 && i4 == 2 ? 2 : 1 for i1=1:1, i2=1:2, i3=1:3, i4=1:4]
