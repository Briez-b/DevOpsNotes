
### Key Concepts

#### 1. **Continuous Integration (CI)**
   - **Definition**: Practice of merging all developer working copies to a shared mainline multiple times a day.
   - **Process**:
     - Developers commit code frequently.
     - Each commit triggers an automated build and test sequence.
     - Early detection of integration issues helps maintain a clean codebase.

#### 2. **Continuous Delivery (CD)**
   - **Definition**: Extends CI by automating the release process to make sure code is always in a deployable state.
   - **Process**:
     - After CI, the code is automatically prepared for a potential release.
     - Includes additional tests, such as performance, load, and user acceptance tests.
     - Deployments are manual but can happen at any time, as the code is always in a releasable state.


During CI there are usually several stages during which some process happens. To describe it, CI Pipelines used. It is usually some file where described what every stage should do with the code(it is like some script). This usually done by tools like Jenkins or GitHub Actions.

Some of the most common steps are:
- Unit testing
- Static Code analysis
- Code quality
- Automation
- Reports
- Deployment
These steps usually executed by orchestrator. For example Jenkins.
Often the quantity of Jenkins machines should be scaled down or up, and every time you have to do manualy if you using Jenkins machines. So it is better to deploy CI on newest tools, for example use kubernetes.

One of the good examples is GitHub Actions. 

