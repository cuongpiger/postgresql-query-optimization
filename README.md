# PostgreSQL Query Optimization

###### 🔨References
- [The air PostgreSQL Database](https://github.com/Hettie-d/postgres_air)

###### 🌈 Table of contents
- [Chapter 1: Why Optimize?](./chap01/README.md)<br>
  _Explains why query optimization should be integrated into PostgreSQL development from the start. Because SQL is declarative, queries that return the same result can perform very differently, so you set SMART goals, optimize for end‑to‑end system performance (across OLTP vs. OLAP), and begin during requirements and schema design—then continue throughout the lifecycle. It highlights PostgreSQL specifics such as new plans per execution and data-only caching, underscoring that declarative, well‑written SQL, indexing, and query rewriting typically matter more than most configuration tweaks._
- [Chapter 2: Understanding the PostgreSQL Query Planner](./chap02/README.md)