Chapter 2 of the sources, titled "**Theory: Yes, We Need It!**," lays the foundational theoretical understanding necessary for comprehending how PostgreSQL executes queries and, consequently, how optimization works. The chapter focuses on the **query processing overview** and the different levels of operations used by the database engine: relational, logical, and physical.

### 1. Query Processing Overview

The database engine must convert a declarative SQL query (which specifies _what_ results are needed, not _how_ to get them) into executable code. PostgreSQL performs this in three main steps:

1.  **Compilation and Transformation:** The SQL statement is compiled and converted into an expression consisting of high-level logical operations, called a **logical plan**. This is similar to compiling code in an imperative language, but the output remains declarative.
2.  **Optimization:** The optimizer transforms the logical plan into an **execution plan**. This involves:
    - Replacing logical operations with specific **execution algorithms** (physical operations).
    - Potentially changing the structure of the logical expression by reordering operations.
      The optimizer attempts to find the plan (the sequence of physical operations) that minimizes the required computational resources, including execution time. The output of this phase is the physical execution plan.
3.  **Execution:** The query execution plan is interpreted by the query execution engine (the executor), and results are returned to the client.

### 2. Relational, Logical, and Physical Operations

To understand query processing deeply, database developers must understand the basics of **relational theory** and how its operations correspond to the query language.

#### Relational Operations (Relational Algebra)

The fundamental concept is the **relation** (viewed as a table for practical purposes), and relational operations take one or more relations as arguments and produce another relation as output. These operations can be combined to build complex expressions.

The primary operations discussed include:

- **Filter (Selection/Restriction):** Accepts a single relation and outputs all rows satisfying a specified condition.
- **Project:** Takes a single relation and removes some columns (attributes). Crucially, the relational project operation **removes duplicates** from its output, unlike the default SQL `SELECT` operation.
- **Product (Cartesian Product):** Produces the set of all pairs of rows from its two input relations.
  - A **join operation** can be formally expressed as a **product followed by filtering**.

Relational operations also include set operations (union, intersection, set difference) and **equivalence rules** (such as **Commutativity**, **Associativity**, and **Distributivity**). These rules are vital because they guarantee that a query can be represented by **several different expressions** that produce the same result, giving the optimizer the ability to choose the most efficient plan.

#### Logical Operations

The set of logical operations used to represent SQL queries includes all relational operations, but their semantics may differ slightly (e.g., the SQL project operation does not automatically remove duplicates).

- Logical operations accept tables as arguments, which can be stored tables or results from previous operations.
- The optimizer replaces the initial SQL expression with an equivalent expression by applying equivalence rules.
- The results of relational operations can be passed directly to the next operation **without intermediate storage** (temporary tables), enabling the optimizer to produce efficient plans.

#### Operations and Algorithms (Physical Operations)

For a query to be executable, the declarative logical operations must be replaced by **physical operations** (or algorithms). The query planner is responsible for this replacement, and the query's total execution time depends on the algorithms chosen. These algorithms are discussed in detail in Chapter 3.
