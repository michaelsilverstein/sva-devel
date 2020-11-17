# Load counts
counts <- read.csv('~/Boston_University/Challenge_Project/3_levels.csv')
counts <- data.matrix(counts[2:ncol(counts)])

# Levels
levels <- rep(c(0, 1, 2), each=4)

# Apply batch correction
corrected <- ComBat_seq(counts, levels)

# Apply reference batch correction
ref.batch <- 1
ref_corrected <- ComBat_seq(counts, levels, ref.batch = ref.batch)

# Calculate pairwise distances
jsd_before <- JSD(t(counts))
jsd_after <- JSD(t(corrected))
jsd_ref <- JSD(t(ref_corrected))

# PCA
pca_before <- prcomp(jsd_before)$rotation[,c(1,2)]
pca_after <- prcomp(jsd_after)$rotation[,c(1,2)]
pca_ref <- prcomp(jsd_ref)$rotation[,c(1,2)]

# Combine with metadata
md <- read.csv('~/Boston_University/Challenge_Project/3_levels_md.csv')
pca_before <- cbind(pca_before, md)
pca_after <- cbind(pca_after, md)

# Plot
ggplot(pca_before) + aes(PC1, PC2, color=batch) + geom_point() + ggtitle('Original')
ggplot(pca_after) + aes(PC1, PC2, color=batch) + geom_point() + ggtitle('Combat-seq')
ggplot(pca_ref) + aes(PC1, PC2, color=batch) + geom_point() + ggtitle('Ref Combat-seq')

