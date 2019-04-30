"""
Solving the clustering problem with Kmeans algorithm.
Introduce the set of (x,y) data and the nomber of K clusters in the function kmeansmy to get the groups of point that form part of every set Si.
The same function also give the centroids coordinates of each subgroup and the number of steps to achieve the agrupations.
The function graficaclusters give a plot of the data with the subgroups indicated and also display the centroids of each subgroup.
You can create a set of randn points with:
    X=vcat([(0.3*randn(),0.3*randn()) for i=1:100],[(1+.3*randn(),1+.3*randn()) for i=1:100],[(1+.3*randn(),-1+.3*randn()) for i=1:100]);
"""

function kmeansmy(data,k)
    M=[[(0.3*randn(),0.3*randn()) for i=1:k]]
    push!(M,[(0.3*randn(),0.3*randn()) for i=1:k])
    step=1;
    N=length(data)

    while M[end]!=M[end-1]
        Mnext=[]
        global S=[[] for i=1:k];

        distancias=[[] for i=1:N];

        for i=1:k,j=1:N
            push!(distancias[j],distanciacartesiana(data[j],M[end][i]))
        end

        for i=1:N,j=1:length(S)
            if minimum(distancias[i])==distancias[i][j]
                push!(S[j],data[i])
            end
        end

        for j=1:k
            push!(Mnext,(mean([S[j][i][1] for i=1:length(S[j])]),mean([S[j][i][2] for i=1:length(S[j])])))
        end

        push!(M,Mnext)
        step+=1
    end

    return S,M[end],step

end

function graficaclusters(data,k)
    S=kmeansmy(data,k)[1]
    C=kmeansmy(data,k)[2]

    scatter([S[1][j] for j=1:length(S[1])],markercolor=[:blue]);
    for i=2:k
        scatter!([S[i][j] for j=1:length(S[i])]);
    end
    scatter!([C[j] for j=1:length(C)],markercolor=[:yellow])
end

function distanciacartesiana(pto1,pto2)
    dis=sqrt((pto1[1]-pto2[1])^2+(pto1[2]-pto2[2])^2);
    return dis;
end
