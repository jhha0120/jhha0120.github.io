# CLAUDE.md - Technical Documentation for Claude Code

## Project Overview
This is a Jekyll-based portfolio website showcasing artworks organized by year. The site uses a custom Jekyll theme (jekyll-theme-lightning) integrated directly into the project structure.

## Technology Stack

### Core Dependencies
- **Ruby**: 3.3.6 (arm64-darwin24)
- **Jekyll**: ~4.3
- **Jekyll Plugins**:
  - jekyll-seo-tag (SEO metadata management)
  - jekyll-feed (RSS feed generation)

### Build System
- Static site generator: Jekyll
- Output directory: `_site/`
- Cache directory: `.jekyll-cache/`

## Project Structure

### Directory Layout
```
.
├── _data/               # Site data files
│   └── navigation.yml   # Navigation menu structure
├── _includes/           # Reusable HTML components
├── _layouts/            # Page layout templates
│   ├── default.html     # Base layout
│   ├── artwork.html     # Individual artwork page
│   └── artworks.html    # Artwork listing page
├── _posts/              # Artwork posts
│   └── artworks/        # Organized by year
│       ├── 2007-2025/   # Year-specific directories
├── _sass/               # SCSS stylesheets
│   └── jekyll-theme-lightning/  # Theme styles
├── assets/
│   ├── images/
│   │   └── artworks/    # Artwork images by year
│   │       ├── [year]/  # Full-size images
│   │       └── thumbs/  # Thumbnail images
│   └── custom.js        # Custom JavaScript
└── artwork[year].html   # Year-specific listing pages
```

## Content Management

### Artwork Posts Structure
Each artwork is a Markdown file in `_posts/artworks/[year]/` with the following frontmatter:

```yaml
---
layout: "artwork"           # Layout template to use
categories: "[year]"        # Year category (e.g., "2025")
author: "Jihoon Ha"        # Artist name
title: "[artwork title]"    # Artwork title
caption: "[full caption]"   # Display caption with technical details
image: "[path to image]"    # Full-size image path
thumb: "[path to thumb]"    # Thumbnail image path
order: [number]            # Display order (higher = first)
orderByYear: [year]        # Year for sorting
---
```

### Image Path Convention
- Full images: `/assets/images/artworks/[year]/[filename].jpg`
- Thumbnails: `/assets/images/artworks/[year]/thumbs/[filename].jpg`
- URL encoding required for special characters (spaces → %20)

## Navigation System

### Current Structure (_data/navigation.yml)
```yaml
items:
  - title: artwork
    url: /artwork/2025
    subitems:
      - title: 2025
        url: /artwork/2025
      - title: 2024
        url: /artwork/2024
      - title: 2023
        url: /artwork/2023
      - title: 2022-2021    # Grouped years
        url: /artwork/2022-2021
      # ... more year groups
```

### Year Grouping Pages
Each year/group has a corresponding HTML file:
- Single year: `artwork2025.html`
- Grouped years: `artwork2022-2021.html`

These files define:
- `layout: artworks` - Uses the artworks listing layout
- `item: [year/group]` - Category filter for posts
- `permalink: /artwork/[path]` - URL structure

## Layout Templates

### artworks.html Layout
- Lists all posts in specified category
- Sorts by `order` field (descending)
- Displays thumbnail grid with captions
- Filters using: `site.posts | where:"categories", page.item`

### artwork.html Layout
- Individual artwork display
- Shows full-size image in table structure
- Displays caption below image
- Includes "Back" navigation link

## Adding New Artworks

### Process for New Artwork
1. **Create post file**: `_posts/artworks/[year]/[date]-[slug].md`
   - Date format: `YYYY-MM-DD`
   - Slug: lowercase, hyphens for spaces

2. **Add images**:
   - Full: `assets/images/artworks/[year]/[filename]`
   - Thumb: `assets/images/artworks/[year]/thumbs/[filename]`

3. **Set frontmatter**:
   - Ensure `categories` matches year
   - Set appropriate `order` value
   - Use URL-encoded paths for special characters
   - **Caption formatting**: Use proper unit symbols (× for dimensions, ㎝ for centimeters)
     - Example: `caption: "artwork title_medium_117×91㎝_year"`
     - **DO NOT** use keyboard characters like "x" and "cm"

### Process for New Year
1. Create year listing page: `artwork[year].html`
2. Update `_data/navigation.yml` with new year/group
3. Create directory: `_posts/artworks/[year]/`
4. Create image directories: `assets/images/artworks/[year]/` and `/thumbs/`

## Year Grouping Modification

### Current Groups
- Individual years: 2025, 2024, 2023, 2018, 2017
- Grouped years: 2022-2021, 2020-2019, 2016-2015, 2014-2012, 2011-2010, 2009-2007

### To Change Grouping
1. **Update navigation.yml**: Modify subitems titles and URLs
2. **Update/create HTML files**: Match new group names
3. **Update post categories**: Ensure posts have correct category values
4. **Consider permalinks**: Update to maintain URL consistency

## Build and Development

### Commands
```bash
# Install dependencies
bundle install

# Build site
bundle exec jekyll build

# Serve locally with auto-rebuild
bundle exec jekyll serve

# Clean build artifacts
bundle exec jekyll clean
```

### Generated Files
- Output: `_site/` directory
- Cache: `.jekyll-cache/`
- Both are git-ignored

## Important Technical Notes

1. **Theme Integration**: Theme files are embedded in `_sass/jekyll-theme-lightning/` rather than using gem-based theme

2. **Image Handling**:
   - Use URL encoding for special characters in paths
   - Maintain consistent thumb/full image structure
   - Images are version-controlled (not generated)
   - **File naming**: Use only basic keyboard characters in filenames (a-z, 0-9, -, _, spaces)
     - **DO NOT** use special Unicode symbols like ×, ㎝ in image/thumb paths
     - These symbols are for caption display only

3. **Post Ordering**:
   - Uses custom `order` field, not date
   - Higher order values display first
   - Reverse sort applied in template

4. **Category System**:
   - Categories match year or year-group exactly
   - Used for filtering posts in listing pages
   - Single category per post

5. **No Package.json**: This is a pure Jekyll site without Node.js dependencies

6. **Custom Domain**: CNAME file contains `jihoonha.com`

## Common Tasks

### Update Existing Artwork
1. Locate post file in `_posts/artworks/[year]/`
2. Update frontmatter or content
3. Replace images if needed
4. Rebuild site

### Reorder Artworks
- Adjust `order` values in post frontmatter
- Higher values appear first

### Change Navigation Structure
1. Edit `_data/navigation.yml`
2. Update corresponding HTML files
3. Ensure post categories align with new structure