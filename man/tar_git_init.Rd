% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tar_git_init.R
\name{tar_git_init}
\alias{tar_git_init}
\title{Initialize a data repository (Git).}
\usage{
tar_git_init(
  store = targets::tar_config_get("store"),
  stash_gitignore = TRUE,
  git_lfs = TRUE,
  verbose = TRUE
)
}
\arguments{
\item{store}{Character of length 1, path to the data store of the pipeline.
If \code{NULL}, the \code{store} setting is left unchanged in the
YAML configuration file (default: \verb{_targets.yaml}).
Usually, the data store lives at \verb{_targets}.
Set \code{store} to a custom directory
to specify a path other than \verb{_targets/}. The path need not exist
before the pipeline begins, and it need not end with "_targets",
but it must be writeable.
For optimal performance, choose a storage location
with fast read/write access.}

\item{stash_gitignore}{Logical of length 1, whether to temporarily
stash the \code{.gitignore} file of the data store. See the
"Stashing .gitignore" section for details.}

\item{git_lfs}{Logical, whether to automatically opt into Git LFS to track
large files in \verb{_targets/objects} more efficiently. If \code{TRUE}
and Git LFS is installed, it should work automatically. If \code{FALSE},
you can always opt in later by running \verb{git lfs track objects}
inside the data store.}

\item{verbose}{Logical of length 1, whether to print messages to the
R console.}
}
\value{
\code{NULL} (invisibly).
}
\description{
Initialize a Git repository for a \code{targets} data store.
}
\details{
\code{tar_git_init()} also writes a \code{.gitattributes} file to the
store to automatically track target output date with \code{git-lfs}
if it is installed on your system.
}
\section{Stashing .gitignore}{

The \code{targets} package writes a \code{.gitignore} file to new data stores
in order to prevent accidental commits to the code Git repository.
Unfortunately, for \code{gittargets}, this automatic \code{.gitignore} file
interferes with proper data versioning. So by default, \code{gittargets}
temporarily stashes it to a hidden file called \code{.gittargets_gitignore}
inside the data store. If your R program crashes while the stash
is active, you can simply move it manually back to \code{.gitignore}
or run \code{tar_git_status_data()} to restore the stash automatically
if no \code{.gitignore} already exists.
}

\examples{
if (Sys.getenv("TAR_EXAMPLES") == "true" && tar_git_ok(verbose = FALSE)) {
targets::tar_dir({ # Containing code does not modify the user's file space.
targets::tar_script(tar_target(data, 1))
targets::tar_make()
tar_git_init()
})
}
}
\seealso{
Other git: 
\code{\link{tar_git_checkout}()},
\code{\link{tar_git_log}()},
\code{\link{tar_git_ok}()},
\code{\link{tar_git_snapshot}()},
\code{\link{tar_git_status_code}()},
\code{\link{tar_git_status_data}()},
\code{\link{tar_git_status_targets}()},
\code{\link{tar_git_status}()}
}
\concept{git}
