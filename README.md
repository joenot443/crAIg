# What is crAIg?
crAIg is a self-teaching AI built by [Joe Crozier](http://joecrozier.ca) and [Nikolai Savas](http://savas.ca) for [YHack](http://yhack.org).

# How does crAIg work?
crAIg is a uses Neuroevolution to learn how to play Mario. Neuroevolution is the artificial evolution of neural networks through genetic algorithms. In simpler terms, crAIg evolves much like species do, selecting for success every generation.

crAIg started out knowing nothing about Mario, or even what a game is. All crAIg starts with is a list of inputs and outputs, and he uses these to learn how to play Mario.

# NEAT Algorithm
The algorithm that crAIg uses to evolve is called "NEAT", based off of this paper published in the MIT Press Journals by Kenneth O. Stanely and Risto Miikkulainen: [Evolving Neural Networks through Augmented Topologies](http://nn.cs.utexas.edu/downloads/papers/stanley.ec02.pdf). An indepth explanation to the implementation of the NEAT algorithm from a programmers perpsective can be found [here](https://medium.com/@savas/craig-using-neural-networks-to-learn-mario-a76036b639ad).

The code for the NEAT algorithm is all held within the NEAT folder. Check it out! To modify the way that crAIg breeds and selects, you can modify the NEAT/config.lua file.

# How to run crAIg
1. Clone this repo
2. Download [FCEUX](www.fceux.com/web/download.html)
3. Open FCEUX and click File -> Open ROM -> runtime/Super Mario Bros. (Japan, USA).nes
4. Press enter to start the game (wait for mario to be standing on the ground)
5. File -> Lua -> New Lua Script Window
6. Browse... "crAIg.lua"
7. Click "Run"
8. Watch crAIg learn!