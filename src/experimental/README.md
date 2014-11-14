This is an experiment to drastically pare down CMakeLists.txt to a minimal, but
functional build configuration, addressing the following high-level goals:

- Concise build scripts
- Incremental builds
- Cross platform
- "best practices"

To build using this configuration:

    mkdir -p build/
    cd build/
    cmake ../src/experimental
    make
    make install

The `make` command above will build nupic.core from source in the current
directory "build/", and `make install` will install the result to a standard
location (most likely /usr/local).

To install to an alternate location, specify `-DCMAKE_INSTALL_PREFIX` in the
call to `cmake`.  For example:

    cmake ../src/experimental -DCMAKE_INSTALL_PREFIX=../release
    make
    make install

At which point, `../release` will have a directory structure that looks like:

    ../release/
    ├── bin
    │   ├── helloregion
    │   └── testcpphtm
    ├── include
    │   ├── gtest
    │   │   └── gtest
    │   │       └── gtest.h
    │   └── nta
    │       ├── Version.hpp
    │       ├── algorithms
    │       │   ├── ArrayBuffer.hpp
    │       │   ├── BitHistory.hpp
    │       │   ├── Cell.hpp
    │       │   ├── Cells4.hpp
    │       │   ├── ClassifierResult.hpp
    │       │   ├── CondProbTable.hpp
    │       │   ├── FDRCSpatial.hpp
    │       │   ├── FDRSpatial.hpp
    │       │   ├── FastClaClassifier.hpp
    │       │   ├── FlatSpatialPooler.hpp
    │       │   ├── GaborNode.hpp
    │       │   ├── ImageSensorLite.hpp
    │       │   ├── InSynapse.hpp
    │       │   ├── Linear.hpp
    │       │   ├── OutSynapse.hpp
    │       │   ├── Scanning.hpp
    │       │   ├── Segment.hpp
    │       │   ├── SegmentUpdate.hpp
    │       │   ├── SpatialPooler.hpp
    │       │   ├── Svm.hpp
    │       │   └── SvmT.hpp
    │       ├── engine
    │       │   ├── Input.hpp
    │       │   ├── Link.hpp
    │       │   ├── LinkPolicy.hpp
    │       │   ├── LinkPolicyFactory.hpp
    │       │   ├── Network.hpp
    │       │   ├── NuPIC.hpp
    │       │   ├── Output.hpp
    │       │   ├── Region.hpp
    │       │   ├── RegionImpl.hpp
    │       │   ├── RegionImplFactory.hpp
    │       │   ├── Spec.hpp
    │       │   ├── TestFanIn2LinkPolicy.hpp
    │       │   ├── TestNode.hpp
    │       │   ├── UniformLinkPolicy.hpp
    │       │   └── YAMLUtils.hpp
    │       ├── math
    │       │   ├── Array2D.hpp
    │       │   ├── ArrayAlgo.hpp
    │       │   ├── Convolution.hpp
    │       │   ├── DenseMatrix.hpp
    │       │   ├── Domain.hpp
    │       │   ├── Erosion.hpp
    │       │   ├── Functions.hpp
    │       │   ├── GraphAlgorithms.hpp
    │       │   ├── Index.hpp
    │       │   ├── Math.hpp
    │       │   ├── NearestNeighbor.hpp
    │       │   ├── Rotation.hpp
    │       │   ├── Set.hpp
    │       │   ├── SparseBinaryMatrix.hpp
    │       │   ├── SparseMatrix.hpp
    │       │   ├── SparseMatrix01.hpp
    │       │   ├── SparseMatrixAlgorithms.hpp
    │       │   ├── SparseRLEMatrix.hpp
    │       │   ├── SparseTensor.hpp
    │       │   ├── StlIo.hpp
    │       │   ├── Types.hpp
    │       │   └── Utils.hpp
    │       ├── ntypes
    │       │   ├── Array.hpp
    │       │   ├── ArrayBase.hpp
    │       │   ├── ArrayRef.hpp
    │       │   ├── Buffer.hpp
    │       │   ├── BundleIO.hpp
    │       │   ├── Collection.hpp
    │       │   ├── Dimensions.hpp
    │       │   ├── MemParser.hpp
    │       │   ├── MemStream.hpp
    │       │   ├── NodeSet.hpp
    │       │   ├── ObjectModel.h
    │       │   ├── ObjectModel.hpp
    │       │   ├── Scalar.hpp
    │       │   └── Value.hpp
    │       ├── os
    │       │   ├── Directory.hpp
    │       │   ├── DynamicLibrary.hpp
    │       │   ├── Env.hpp
    │       │   ├── FStream.hpp
    │       │   ├── OS.hpp
    │       │   ├── Path.hpp
    │       │   ├── Regex.hpp
    │       │   └── Timer.hpp
    │       ├── regions
    │       │   ├── VectorFile.hpp
    │       │   ├── VectorFileEffector.hpp
    │       │   └── VectorFileSensor.hpp
    │       ├── test
    │       │   └── Tester.hpp
    │       ├── types
    │       │   ├── BasicType.hpp
    │       │   ├── Exception.hpp
    │       │   ├── Fraction.hpp
    │       │   ├── Types.h
    │       │   └── Types.hpp
    │       └── utils
    │           ├── Log.hpp
    │           ├── LogItem.hpp
    │           ├── LoggingException.hpp
    │           ├── Random.hpp
    │           ├── StringUtils.hpp
    │           ├── TRandom.hpp
    │           └── Watcher.hpp
    └── lib
        ├── libgtest.a
        └── libnupic_core.a

*Note:* Files will only be copied into the install prefix upon `make install`

You may optionally install the bundled external dependencies by specifying the
"RelWithExternals" build type:

    cmake ../../src/external -DCMAKE_BUILD_TYPE=RelWithExternals
