# Kalman Filter for Beginners

Sample code for the book *Kalman Filter for Beginners* (2nd Edition), in MATLAB / GNU Octave.

You opened a Kalman filter textbook, found four chapters of probability theory before the first equation, and closed it. This book is the alternative.

The Kalman filter has a reputation problem. The algorithm itself isn't particularly hard — it's the way it has been taught for more than sixty years that makes it feel hard. Most books lead with derivations and proofs, and most readers never make it to the filter. If that's your story, this book was written for you.

This book doesn't ask you to derive the Kalman filter. It asks you to run it. Every concept is introduced through a short MATLAB example you can run and modify. There's math, of course — but the math is there to explain what the code is doing, not the other way around.

It also gives the Error-State Kalman Filter the introduction it has been missing. The ESKF is now the standard tool for orientation and pose estimation in drones, robots, AR headsets, and spacecraft, yet it's notoriously hard to learn — even experienced practitioners regularly confuse it with the ordinary EKF. This book draws the distinction sharply: why the ESKF exists, and how it relates to the EKF in terms a reader who finished the earlier chapters can follow. An appendix sketches the connection to Lie groups for those who want to keep going.

## The six filters

The book teaches six filters and shows how they relate:

- **Standard Kalman filter** — the foundation, for linear systems
- **Extended Kalman filter** — for nonlinear systems
- **Unscented Kalman filter** — for when linearization breaks down
- **Particle filter** — for when the noise itself is non-Gaussian
- **Error-State Kalman filter** — the modern workhorse for fusing IMU data with other sensors when rotation is involved
- **Complementary filter** — the frequency-domain alternative engineers reach for when a full Kalman filter is overkill

Two unifying examples run through the book. The same radar-tracking problem is solved with the EKF, the UKF, and the particle filter, side by side, so you can see where each algorithm works best and where it doesn't. Tilt-attitude estimation — fusing a gyroscope and an accelerometer to figure out which way is up — is solved with the EKF, the ESKF, and the complementary filter. By the end you'll know not just what each filter is, but which one to reach for.

**What you need to bring:** basic linear algebra and access to MATLAB or GNU Octave.

**What you leave with:** the Kalman filter as a tool you can use, not a theory you fear.

## Sample code

| Edition | Location |
|---------|----------|
| 2nd Edition (current) | [`2nd-edition/`](./2nd-edition/) |
| 1st Edition | [`1st-edition/`](./1st-edition/) |

The 2nd edition code runs unmodified on both **MATLAB** and **GNU Octave**, and
has been verified on **MATLAB R2022b** and **GNU Octave 11.1.0**.

## The book

- **Title:** Kalman Filter for Beginners (2nd Edition)
- **Author:** Phil Kim
- **Buy:** [_Amazon_](https://a.co/d/0dfgmoj1)

## License

The sample code in this repository is released under the [MIT License](./LICENSE) —
you are free to use, modify, and redistribute it, including in commercial
projects, provided the copyright and license notice are retained.

Note: the MIT License covers the **code only**. The text and figures of the
book itself remain under the author's / publisher's copyright.
