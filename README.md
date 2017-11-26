# SGP4 Satellite Propagation for Ruby

This code predicts the location of a satellite,
given a time,
based on NORAD Two-Line Elements.
This is, I believe, the most widely used way of predicting a satellite location.

This code is very much a work in progress.

# Road Map
The priorities right now are to:

* Update this README with more instructions on contributing
* Understand what's causing the differences between the test results
from the Celestrak source code, and this code
* Document the methods
* Publish to `rubygems.org` as a pre-release gem

Later, I hope to:

* Add the code to translate the satellite position
into units that make more sense to an Earth-bound observer
* Simplify the implementation

# Implementation

There are currently two "top-level" Ruby modules in this code:

* `Sgp4`, which uses the C++ code
published on the Celetrak web site ([zip file](http://celestrak.com/publications/AIAA/2006-6753/AIAA-2006-6753.zip)).
This is the code that is being actively developed

* `Sgp4sdp4`, which uses the C code
from [Bill Gray's Github](https://github.com/Bill-Gray/sat_code).
I'm not currently working on this code,
and I'm not confident that the answers I'm getting are correct

One important implementation goal I have is to leave the propagation code
exactly as it is from the original source,
as much as possible.

# Contributions
Contributions are welcome.
Please note that this project is released with a
[Contributor Code of Conduct](https://github.com/lcreid/ruby-sgp4sdp4/blob/master/code-of-conduct.md).
By participating in this project you agree to abide by its terms.

My apologies for not documenting more thoroughly
how to contribute.
For now what I can say is that we use a fairly common process.
If you want to contribute:

* Add an issue to this repository proposing the addition or change,
or identifying the defect you wish to fix
* Although it's unlikely that I'll refuse any reasonable offer of help,
you may want to wait for me to say, "go ahead" before you do too much work
* Fork this repository
* Add your code. All code must be tested by automated tests
* Submit a pull request

# References

The canonical paper to read on orbital propagation is
[Revisiting Spacetrack Report #3: Rev 2](http://celestrak.com/publications/AIAA/2006-6753/AIAA-2006-6753-Rev2.pdf).

The original research and development of this code was done by Dr. T. S. Kelso.
He runs the [Celestrak Web Site](http://celestrak.com/).
The code run by the `Sgp4` module is from http://celestrak.com/publications/AIAA/2006-6753/AIAA-2006-6753.zip.

The code in the `Sgp4sdp4` module is from [Bill Gray's Github](https://github.com/Bill-Gray/sat_code).

There is another implementation of the C code at [Daniel Warner's Github](https://github.com/dnwrnr/sgp4), with links to his web site: https://www.danrw.com/sgp4/.

# Background
My background is a software developer.
From about 1994 to 2000 I developed software
that was delivered to the
Canada Centre for Remote Sensing
and the Australian Centre for Remote Sensing.
As part of those projects,
I ported Dr. Kelso's original Pascal implementation
to C.

I'm a software developer, not a rocket scientist.
While I believe that everything in this README is true,
I strongly encourage you to read the original material
on this topic,
particularly the material published by Dr. Kelso
and his colleagues.

# License
The code developed exclusively for this repository
is shared under the MIT License.
That includes all the Ruby code,
and the C and C++ code
that implements the Ruby extension.

To the best of my knowledge,
the C++ code used in the `Sgp4` module
is in the public domain.

Bill Gray's code is under the GNU GPL v2.0.
