# PostgreSQL Query Optimization

###### 🔨References
- [The air PostgreSQL Database](https://github.com/Hettie-d/postgres_air)

###### 🌈 Table of contents
- [Chapter 1: Why Optimize?](./chap01/README.md)<br>
  _Explains why query optimization should be integrated into PostgreSQL development from the start. Because SQL is declarative, queries that return the same result can perform very differently, so you set SMART goals, optimize for end‑to‑end system performance (across OLTP vs. OLAP), and begin during requirements and schema design—then continue throughout the lifecycle. It highlights PostgreSQL specifics such as new plans per execution and data-only caching, underscoring that declarative, well‑written SQL, indexing, and query rewriting typically matter more than most configuration tweaks._
- [Chapter 2: Theory: Yes, We Need It!](./chap02/README.md)<br>
  _Builds the theoretical foundation for PostgreSQL query optimization, outlining how a declarative SQL statement is compiled into a logical plan, optimized into a physical execution plan, and then executed. It distinguishes relational, logical, and physical operations, highlights equivalence rules (commutativity, associativity, distributivity) that enable plan rewrites, and explains that the optimizer selects concrete algorithms to minimize resource use—setting the stage for deeper dives into execution strategies.__
- [Chapter 3: Even More Theory: Algorithms](./chap03/README.md)<br>
  _Covers the physical algorithms PostgreSQL uses to execute queries, focusing on cost models (CPU + I/O), data access methods (sequential scan vs. index scan vs. bitmap scan vs. index-only scan), index structures (B-tree, hash, GIN, GIST), and join algorithms (nested loops, hash join, sort-merge). It emphasizes that no single algorithm is universally best—selectivity, table size, and join conditions determine the optimal choice, and the optimizer picks the lowest-cost plan._