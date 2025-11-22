# Archives Management System Demo

This project serves as a proof-of-concept implementation for an archival management system, specifically designed to test data validation strategies and advanced search logic within a Prolog environment. It is not a production-ready application but rather a demonstration of how logic programming can handle complex archival relationships and controlled vocabularies.

The core functionality revolves around a hierarchical organization of collections, files, and items, enforced by strict validation rules. These rules ensure that all archival data adheres to specific ID formats and maintains referential integrity across the dataset. Additionally, the system integrates a thesaurus-based controlled vocabulary to standardize metadata for subjects, people, locations, and organizations.

A key feature of this implementation is the fuzzy search combiner logic. This allows for flexible querying by calculating string similarities (using Levenshtein distance) and normalizing input. It enables users to find records even with typos, partial matches, or variations in naming conventions across multiple fields simultaneously, such as combining subject and location searches into a single fuzzy query.

## Getting Started

To explore the capabilities of this demo, load the `demo.pl` file into a SWI-Prolog environment. Running `archives_main.` will execute a series of demonstrations that showcase the derived relationships, data validation checks, and the various fuzzy search scenarios.

The project structure separates the core logic (`archives.pl`), the sample data (`data.pl`), and the controlled vocabulary definitions (`thesaurus/` directory), providing a clean modular architecture for testing different archival modeling approaches.

---
*This is a demo implementation for educational purposes.*