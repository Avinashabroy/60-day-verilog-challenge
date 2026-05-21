# =========================================================
# FIFO Full and Empty Logic Explanation
# =========================================================

# FIFO Basics
#
# FIFO = First In First Out
#
# Data written first will be read first.
#
# Example:
#
# Write : 10 -> 20 -> 30
# Read  : 10 -> 20 -> 30


# =========================================================
# Example FIFO
# =========================================================

# Suppose FIFO depth = 4
#
# Memory locations:
#
# 0 1 2 3


# =========================================================
# Problem
# =========================================================

# If:
#
# wr_ptr == rd_ptr
#
# How do we know FIFO is:
#
# EMPTY ?
# or
# FULL ?
#
# Because both conditions are possible.


# =========================================================
# Case 1 : FIFO EMPTY
# =========================================================

# Example:
#
# wr_ptr = 3
# rd_ptr = 3
#
# Meaning:
#
# - Write pointer and read pointer are at same location
# - No unread data available
#
# FIFO is EMPTY.


# =========================================================
# Case 2 : FIFO FULL
# =========================================================

# Write pointer continuously writes and wraps around:
#
# 0 -> 1 -> 2 -> 3 -> 0 -> 1 -> 2 -> 3
#
# Again:
#
# wr_ptr = 3
# rd_ptr = 3
#
# But now FIFO is FULL.


# =========================================================
# Big Problem
# =========================================================

# Both conditions show:
#
# wr_ptr == rd_ptr
#
# So we cannot distinguish:
#
# - EMPTY
# - FULL
#
# using only address bits.


# =========================================================
# Solution : Add One Extra Bit
# =========================================================

# Instead of:
#
# 2-bit pointer
#
# Use:
#
# 3-bit pointer
#
# Pointer format:
#
# [extra_bit][address_bits]
#
# Extra bit tells:
#
# Did pointer wrap around FIFO or not?


# =========================================================
# EMPTY Example
# =========================================================

# wr_ptr = 011
# rd_ptr = 011
#
# Address bits same
# Extra bit same
#
# FIFO is EMPTY.


# =========================================================
# FULL Example
# =========================================================

# wr_ptr = 111
# rd_ptr = 011
#
# Address bits:
#
# 11 == 11
#
# Extra bits:
#
# 1 != 0
#
# Meaning:
#
# Write pointer completed one extra cycle.
#
# FIFO is FULL.


# =========================================================
# Circular Buffer Analogy
# =========================================================

# Think of FIFO as circular race track.
#
# Read pointer:
#
# standing at location 3
#
# Write pointer:
#
# also standing at location 3
#
# BUT write pointer completed one extra lap.
#
# Therefore FIFO is FULL.


# =========================================================
# FIFO Rules
# =========================================================

# All bits equal
# -> FIFO EMPTY
#
# Address bits equal
# + extra bit different
# -> FIFO FULL


# =========================================================
# Full Logic
# =========================================================

assign full = (

    (wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]) &&

    (wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0])

);


# =========================================================
# Empty Logic
# =========================================================

assign empty = (wr_ptr == rd_ptr);
