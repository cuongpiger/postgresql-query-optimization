Chapter 3 of the source, "Even More Theory: Algorithms," introduces the physical operations and algorithms necessary for executing queries, serving as the last theoretical foundation before diving into execution plans.

### Algorithm Cost Models

The PostgreSQL optimizer estimates the cost of physical operations using **internal metrics**, primarily based on the amount of computing resources needed, specifically **CPU cycles** and **I/O accesses** (reading or writing disk blocks).

- The optimizer must combine these metrics into a single **cost function** to compare execution plans, aiming for the lowest total cost.
- Historically, I/O cost dominated due to the slowness of rotating hard drives, but this may vary with modern hardware.
- A simplified cost model estimates resources by counting the number of low-level operations performed per row or per storage block.
- For any table $R$, $T_R$ denotes the number of rows, and $B_R$ denotes the number of storage blocks occupied.
- Logical operations such as `project` and `filter` are typically combined with preceding operations because their associated costs are usually negligible.

### Data Access Algorithms

These algorithms are used to retrieve stored data, which is physically organized into **blocks** (typically 8192 bytes in PostgreSQL). The efficiency of access depends heavily on **selectivity**, the ratio of rows retained to the total rows in the table.

#### 1. Full Scan (Sequential Scan)

The engine reads and checks every row in the table.

- The total number of I/O accesses is $B_R$.
- The cost is estimated as $c1 \times B_R + c2 \times T_R + c3 \times S \times T_R$, where $S$ is the selectivity.

#### 2. Index-Based Table Access

This approach leverages **indexes**, which are additional, redundant data structures used to determine the location of specific data without reading the entire table.

- For searches with low selectivity, an **index scan** is often used.
- For high selectivity, multiple indexes, or complex filters, a **bitmap index scan** creates a bitmap of heap blocks that might contain matching records. This is followed by a **bitmap heap scan** to read only the candidate blocks.
- The **Index-Only Scan** is the most preferred method if all required columns for the query are contained within the index, as it avoids accessing the main table data entirely.

#### Comparison

The optimal choice between a full scan and index-based access depends on selectivity. Index-based access is preferable for smaller selectivity, while a full scan is often better for higher selectivity, typically when the necessary results exceed a small percentage (e.g., 2–5% for older hardware).

### Index Structures

The fundamental structures of indexes directly impact access efficiency:

- **B-Tree Indexes:** This is the most common index structure and the default in PostgreSQL.
  - It consists of hierarchically organized nodes (disk blocks).
  - The structure supports both **equality** and **range search** (using `between` or inequality operations).
  - Search complexity is logarithmic, proportional to the tree depth ($\log N / \log f$).
  - B-trees can be used for any **ordinal data type**.
- **Other Index Types:** PostgreSQL offers other index structures, including **hash indexes** (fast for equality searches but useless for range queries) and **R-tree indexes** (useful for spatial data search).
- **Generalized Index Types:** Other types include **GIN** (Generalized Inverted) and **GIST** (Generalized Search Tree), which are crucial for complex searches like full text search and spatial search.

### Combining Relations (Join Algorithms)

Complex logical operations like joins are implemented using several alternative algorithms:

1.  **Nested Loops:** The simplest implementation, executing a loop over table $R$ (outer loop) and, for each row, looping over table $S$ (inner loop).

    - The basic cost is proportional to $rows(R) \times rows(S)$.
    - Variations perform nested loops on **blocks** of input tables, followed by loops on **rows**, to minimize expensive disk access operations.
    - The algorithm can be combined with index-based access if $S$ has an index on the join attribute, reducing the inner loop size significantly.

2.  **Hash-Based Algorithms (Hash Join):** Primarily used for **equi-joins**.

    - The algorithm partitions both tables based on a hash function.
    - It consists of a **build phase** (storing $R$ tuples in memory buckets) and a **probe phase** (matching $S$ rows to buckets).
    - The estimated cost, $\text{cost}(\text{hash}, R, S) = \text{size}(R) + \text{size}(S) + \text{size}(R) \times \text{size}(S) / \text{size}(JA)$, makes it significantly faster than nested loops for large tables.

3.  **Sort-Merge Algorithm:** Also used for **equi-joins**.
    - Phase 1: Sorts both input tables by the join attribute.
    - Phase 2: Merges the sorted tables by scanning both once to find matching values.
    - It is particularly efficient if input tables are already sorted.

**Conclusion on Joins:** As with data access, there are no inherent winners among join algorithms; the optimal choice depends on the specific circumstances, table sizes, and join conditions. Hash joins and sort-merge algorithms are generally more efficient for large tables where applicable.
