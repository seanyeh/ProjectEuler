-- Three distinct points are plotted at random on a Cartesian plane, for which -1000 ≤ x, y ≤ 1000, such that a triangle is formed.
--
-- Consider the following two triangles:
--
-- A(-340,495), B(-153,-910), C(835,-947)
--
-- X(-175,41), Y(-421,-714), Z(574,-645)
--
-- It can be verified that triangle ABC contains the origin, whereas triangle XYZ does not.
--
-- Using triangles.txt (right click and 'Save Link/Target As...'), a 27K text file containing the co-ordinates of one thousand "random" triangles, find the number of triangles for which the interior contains the origin.
--
-- NOTE: The first two examples in the file represent the triangles in the example given above.
--


-- Point in triangle algorithm from
-- http://www.blackpawn.com/texts/pointinpoly/

function dot_prod(v1, v2)
    return v1[1]*v2[1] + v1[2]*v2[2] + v1[3]*v2[3]
end


function cross_prod(p1, p2)
    return {0, 0, p1[1]*p2[2] - p1[2]*p2[1]}
end


function sub(p1, p2)
    return {p1[1]-p2[1], p1[2]-p2[2]}
end


function same_side(p1, p2, a, b)
    local cp1 = cross_prod(sub(b,a), sub(p1, a))
    local cp2 = cross_prod(sub(b,a), sub(p2, a))

    return dot_prod(cp1, cp2) >= 0
end


function in_triangle(p, a, b, c)
    return same_side(p, a, b,c) and same_side(p, b, a, c) and same_side(p, c, a, b)
end


function load_file(filename)
    local triangles = {}
    for l in io.lines(filename) do
        local line = {}
        for i in string.gmatch(l, "%S+") do
            line[#line + 1] = i
        end

        triangles[#triangles + 1] = {{line[1], line[2]}, {line[3], line[4]}, {line[5], line[6]}}
    end

    return triangles
end


function main()
    local count = 0

    local triangles = load_file("102.txt")
    for _, t in pairs(triangles) do
        if in_triangle({0,0}, t[1], t[2], t[3]) then
            count = count + 1
        end
    end

    print(count)
end

main()
