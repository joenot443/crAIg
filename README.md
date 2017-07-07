# What is crAIg?
crAIg is a self-teaching AI built by [Joe Crozier](http://joecrozier.ca) and [Nikolai Savas](http://savas.ca) for [YHack](http://yhack.org).

# How does crAIg work?
crAIg is a uses Neuroevolution to learn how to play Mario. Neuroevolution is the artificial evolution of neural networks through genetic algorithms. In simpler terms, crAIg evolves much like species do, selecting for success every generation.

crAIg started out knowing nothing about Mario, or even what a game is. All crAIg starts with is a list of inputs and outputs, and he uses these to learn how to play Mario.

# NEAT Algorithm
The algorithm that crAIg uses to evolve is called "NEAT", based off of this paper published in the MIT Press Journals by Kenneth O. Stanely and Risto Miikkulainen: [Evolving Neural Networks through Augmented Topologies](http://nn.cs.utexas.edu/downloads/papers/stanley.ec02.pdf). An indepth explanation to the implementation of the NEAT algorithm from a programmers perspective can be found [here](https://medium.com/@savas/craig-using-neural-networks-to-learn-mario-a76036b639ad).

The code for the NEAT algorithm is all held within the NEAT folder. Check it out! To modify the way that crAIg breeds and selects, you can modify the NEAT/config.lua file.

# Inspiration
The idea for crAIg was based on [MarIO](https://www.youtube.com/watch?v=qv6UVOQ0F44), built by [SethBling](www.twitch.tv/sethbling). While crAIg attempts to learn about the same game as MarIO, the algorithms present in crAIg differ in some important ways.

1. **Respeciation**: crAIg properly implements the respeciation algorithm described by the NEAT method, whereas MarIO skips over this important part of the implementation. Because of this, as crAIg grows more complex, it is unlikely that one species becomes dominant (for a more detailed explanation see point 6 of [my blog post](https://medium.com/@savas/craig-using-neural-networks-to-learn-mario-a76036b639ad)).

2. **Extinction**: Extinction is new twist on the NEAT algorithm. A similar concept is mentioned briefly in the NEAT paper, but it is implemented in a much more aggressive way in crAIg. The idea is that an underperforming species that continues to underperform will be phased out as it continues to underperform. crAIg does this by keeping track of the placement of each species throughout generations. You can see the implementation of it in NEAT/extinction.lua.

3. **Adjusted Fitness**: crAIg properly implements the adjusted fitness algorithm, which encourages species to stay small as opposed to growing large by imposing a performance penalty on larger species. You can see the implementation of this algorithm in NEAT/util/calculateAdjustedFitnesses.lua. For a more detailed explanation of this, see point 2 in [the blog post](https://medium.com/@savas/craig-using-neural-networks-to-learn-mario-a76036b639ad).

4. **Fitness Function**: crAIg employs a different fitness function than MarIO, leading to more complex and nuanced behaviours of each iteration.

These changes allow for a more robust neural network as it continues to grow, without comprimising crAIg's performance through each generation.

# How to run crAIg
1. Clone this repo
2. Download [FCEUX](http://www.fceux.com/web/download.html)
3. Open FCEUX and click File -> Open ROM -> runtime/Super Mario Bros. (Japan, USA).nes
4. Press enter to start the game (wait for mario to be standing on the ground)
5. File -> Lua -> New Lua Script Window
6. Browse... "crAIg.lua"
7. Click "Run"
8. Watch crAIg learn!
