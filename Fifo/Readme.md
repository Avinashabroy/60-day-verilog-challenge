# FIFO (First In First Out)

## What is FIFO?

FIFO stands for:

```text
First In First Out
```

FIFO is a temporary memory buffer used to store data in the same order it was received.

The first data written into FIFO will be the first data read out.

---

# Real Life Example

FIFO works like a queue.

Example:

```text
Person A enters queue
Person B enters queue
Person C enters queue
```

Exit order:

```text
Person A leaves first
Person B leaves second
Person C leaves third
```

FIFO follows the same principle in digital systems.

---

# FIFO in Digital Electronics

FIFO is used to:

- Temporarily store data
- Transfer data between modules
- Handle speed mismatch between circuits
- Maintain data order

FIFO contains:

- Memory
- Write Pointer
- Read Pointer

---

# FIFO Operation

## Write Operation

Data is written into FIFO memory.

```verilog
mem[wr_ptr] <= wr_data;
```

Write pointer increments after every write.

---

## Read Operation

Data is read from FIFO memory.

```verilog
rd_data <= mem[rd_ptr];
```

Read pointer increments after every read.

---

# FIFO Example

Suppose FIFO depth is 4.

## Write Sequence

```text
Write 10
Write 20
Write 30
```

FIFO contents:

```text
[10 20 30]
```

## Read Sequence

```text
Read -> 10
Read -> 20
Read -> 30
```

The first written data is read first.

---

# Types of FIFO

## 1. Synchronous FIFO

In synchronous FIFO:

```text
Write clock = Read clock
```

Both read and write operations use the same clock.

### Features

- Simple design
- Easy timing analysis
- Commonly used inside FPGA modules

---

## 2. Asynchronous FIFO

In asynchronous FIFO:

```text
Write clock != Read clock
```

Read and write operations use different clocks.

### Features

- Used for clock domain crossing (CDC)
- More complex design
- Uses Gray code pointers and synchronizers

---

# FIFO Status Signals

## FULL

FIFO cannot accept more data.

```verilog
full = 1;
```

---

## EMPTY

FIFO contains no data.

```verilog
empty = 1;
```

---

# FIFO Applications

FIFO is widely used in:

- UART
- SPI
- I2C
- AXI Protocol
- Ethernet
- Video Processing
- DMA Controllers
- Processor Interfaces

---

# Basic FIFO Block Diagram

```text
Write Side ---> FIFO Memory ---> Read Side
```

---

# Key Concept

FIFO always maintains:

```text
Data Order
```

The first data written into FIFO will always be the first data read out.

# FIFO Full and Empty Logic Explanation

## FIFO Basics

FIFO stands for:

```text
First In First Out
```

Data written first will be read first.

Example:

```text
Write : 10 -> 20 -> 30
Read  : 10 -> 20 -> 30
```

---

# Example FIFO

Suppose FIFO depth is:

```text
DEPTH = 4
```

Memory locations:

```text
0 1 2 3
```

---

# Problem

If:

```verilog
wr_ptr == rd_ptr
```

How do we know FIFO is:

- EMPTY
- FULL

Because both conditions are possible.

---

# Case 1 : FIFO EMPTY

Example:

```text
wr_ptr = 3
rd_ptr = 3
```

Meaning:

- Write pointer and read pointer are at same location
- No unread data available

FIFO is EMPTY.

---

# Case 2 : FIFO FULL

Write pointer continuously writes and wraps around:

```text
0 -> 1 -> 2 -> 3 -> 0 -> 1 -> 2 -> 3
```

Again:

```text
wr_ptr = 3
rd_ptr = 3
```

But now FIFO is FULL.

---

# Big Problem

Both conditions show:

```verilog
wr_ptr == rd_ptr
```

So we cannot distinguish:

- EMPTY
- FULL

using only address bits.

---

# Solution : Add One Extra Bit

Instead of:

```text
2-bit pointer
```

Use:

```text
3-bit pointer
```

Pointer format:

```text
[extra_bit][address_bits]
```

The extra bit tells:

```text
Did pointer wrap around FIFO or not?
```

---

# EMPTY Example

```text
wr_ptr = 011
rd_ptr = 011
```

Analysis:

| Part | Value |
|------|--------|
| Extra bit | Same |
| Address bits | Same |

FIFO is EMPTY.

---

# FULL Example

```text
wr_ptr = 111
rd_ptr = 011
```

## Address Bits

```text
11 == 11
```

Same memory location.

## Extra Bit

```text
1 != 0
```

Meaning:

- Write pointer completed one extra cycle
- FIFO is FULL

---

# Circular Buffer Analogy

Think of FIFO as circular race track.

- Read pointer is standing at location 3
- Write pointer is also standing at location 3
- But write pointer completed one extra lap

Therefore FIFO is FULL.

---

# FIFO Rules

| Condition | FIFO Status |
|------------|-------------|
| All bits equal | EMPTY |
| Address bits equal + extra bit different | FULL |

---

# Full Logic

```verilog
assign full = (

    (wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]) &&

    (wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0])

);
```

---

# Empty Logic

```verilog
assign empty = (wr_ptr == rd_ptr);
```

---

# Key Concept

The extra MSB is used only to determine:

```text
Did the write pointer wrap around FIFO?
```

This is the standard synchronous FIFO full/empty detection method.
