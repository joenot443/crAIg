echo "Welcome to the crAIg simulator";
sleep 1;
while [ 1 ]
do
    echo "Switching graphs and synapses"
    cp ../runtime/live/graph.json ../runtime/live/graph_temp.json;
    mv ../runtime/live/graph2.json ../runtime/live/graph.json;
    mv ../runtime/live/graph_temp.json ../runtime/live/graph2.json;

    cp ../runtime/live/litmap.json ../runtime/live/litmap_temp.json;
    mv ../runtime/live/litmap2.json ../runtime/live/litmap.json;
    mv ../runtime/live/litmap_temp.json ../runtime/live/litmap2.json;
    sleep 4;
    echo "Switching back"
    cp ../runtime/live/graph.json ../runtime/live/graph_temp.json;
    mv ../runtime/live/graph2.json ../runtime/live/graph.json;
    mv ../runtime/live/graph_temp.json ../runtime/live/graph2.json;

    cp ../runtime/live/litmap.json ../runtime/live/litmap_temp.json;
    mv ../runtime/live/litmap2.json ../runtime/live/litmap.json;
    mv ../runtime/live/litmap_temp.json ../runtime/live/litmap2.json;
    sleep 4;
done