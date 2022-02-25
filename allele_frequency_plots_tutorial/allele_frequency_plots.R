### Allele Frequency Plots 

library(tidyverse)

# Read list of mutations 
snps <- read.csv(file="/Users/mrs/Documents/pitt/allele_frequency_plots_tutorial/rawdata.csv", header=TRUE, row.names = 1)

# Plot allele frequency for a single lineage
snps %>% 
  # filter the raw data so that only mutations for the lineage of interest are included
  filter(immune == "M0") %>%
  filter(pop == "L1") %>%
  filter(passage < 15) %>%
  # plot 
  ggplot(mapping = aes(x=passage, y=freq, color=gene_annot)) + 
  geom_point(size=0.25) +
  geom_line() +
  scale_x_continuous(breaks = c(0,5,10,15), limits = c(0,15))+
  scale_y_continuous(limits = c(0,100)) + 
  scale_color_discrete(name="Mutation") +
  ylab("Frequency") +
  xlab("Passage") + 
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_rect(fill = "white")) 
# save the plot
ggsave("/Users/mrs/Documents/pitt/allele_frequency_plots_tutorial/singleplot.pdf", device = "pdf", width = 5, height = 5)

# Plot allele frequency for multiple lineages, with faceting by lineage
snps %>% 
  filter(immune == "M0") %>%
  filter(passage < 15) %>%
  ggplot(mapping = aes(x=passage, y=freq, color=gene_annot)) + 
  geom_point(size=0.25) +
  geom_line() +
  scale_x_continuous(breaks = c(0,5,10,15), limits = c(0,15))+
  scale_y_continuous(limits = c(0,100)) + 
  scale_color_discrete(name="Mutation") +
  ylab("Frequency") +
  xlab("Passage") + 
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_rect(fill = "white"),
        legend.text=element_text(size=rel(0.5)),legend.key.width = unit(0.25, 'cm')) +
  facet_wrap(vars(lineage)) 
ggsave("/Users/mrs/Documents/pitt/allele_frequency_plots_tutorial/facetplot.pdf", device = "pdf", width = 5, height = 5)
