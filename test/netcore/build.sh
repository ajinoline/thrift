#!/usr/bin/env bash

#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements. See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership. The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#

#exit if any command fails
#set -e

cd ThriftTest
../../../compiler/cpp/thrift  -gen netcore:wcf   -r  ../../ThriftTest.thrift
cd ..


# Due to a known issue with "dotnet restore" the Thrift.dll dependency cannot be resolved from cmdline
# For details see https://github.com/dotnet/cli/issues/3199 and related tickets
# The problem does NOT affect Visual Studio builds.

# workaround for "dotnet restore" issue
cp  -u -p -r ..\..\lib\netcore\Thrift .\Thrift  

dotnet --info
dotnet restore

# dotnet test ./test/TEST_PROJECT_NAME -c Release -f netcoreapp1.0

# Instead, run directly with mono for the full .net version 
dotnet build **/*/project.json -r win10-x64 
dotnet build **/*/project.json -r osx.10.11-x64 
dotnet build **/*/project.json -r ubuntu.16.04-x64 

#revision=${TRAVIS_JOB_ID:=1}  
#revision=$(printf "%04d" $revision) 

#dotnet pack ./src/PROJECT_NAME -c Release -o ./artifacts --version-suffix=$revision  

# workaround for "dotnet restore" issue
rm -r .\Thrift  

