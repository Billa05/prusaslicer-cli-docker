# Slicing Performance Comparison: 2 Cores vs 16 Cores

This table compares the slicing statistics for each model when run on a 2-core VM versus a 16-core local machine. Key differences:
- **User time** is consistently lower on 16 cores, indicating faster computation.
- **System time** is higher on 16 cores, likely due to increased parallelism and I/O.
- **CPU%** is much higher on 16 cores, showing better CPU utilization.
- **Max RSS** (memory usage) is generally higher on 16 cores, possibly due to more threads in use.

| Model        | User time (2c) | User time (16c) | System time (2c) | System time (16c) | CPU% (2c) | CPU% (16c) | Max RSS (2c) | Max RSS (16c) |
|-------------|---------------|-----------------|------------------|-------------------|-----------|------------|--------------|---------------|
| cat         | 11.26         | 6.79            | 0.22             | 1.16              | 189%      | 287%       | 136604       | 211876        |
| dragon      | 33.55         | 16.89           | 0.33             | 0.83              | 99%       | 298%       | 193052       | 284064        |
| eyeball     | 2.37          | 1.29            | 0.06             | 0.21              | 96%       | 196%       | 81208        | 97536         |
| femaleHead  | 6.20          | 3.73            | 0.15             | 0.75              | 98%       | 214%       | 122796       | 189880        |
| hand        | 5.81          | 3.45            | 0.16             | 0.79              | 96%       | 238%       | 120784       | 163748        |
| test_model  | 33.40         | 16.86           | 0.36             | 0.88              | 99%       | 299%       | 190776       | 292680        |
| wolf        | 1.87          | 0.95            | 0.04             | 0.08              | 97%       | 353%       | 75468        | 79092         | 