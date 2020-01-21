#!/usr/bin/python3

from sh import find
import git
import sys
import argparse
from os import path
import os
from shutil import rmtree

class ReposCluster():
    def __init__(self):
        self.repos = None

    def inhale_repos(self, root_dirs):
        found = []
        for root_dir in root_dirs:
            found += find(root_dir, '-type', 'd', '-name', '.git',)
        found = list(found)
        found = [x.replace('.git\n', '') for x in found]
        self.repos = [git.Repo(x) for x in found]

    def write_manifest(self, root_dirs, manifest_dir):
        for root_dir in root_dirs:
            output_subdir = path.join(manifest_dir, path.basename(root_dir))
            rmtree(output_subdir) if os.path.exists(output_subdir) else None
            os.makedirs(output_subdir)
            with open(path.join(output_subdir, 'manifest' + '.yml'), 'w') as yaml:
                print('writing manifest to ' + output_subdir)
                yaml.write('repos:\n')
                for repo in self.repos:
                    str_ = '  - src: ' + repo.working_dir
                    str_ += '\n'
                    if len(repo.remotes):
                        str_ += '    remotes:\n'
                    for remote in repo.remotes:
                        str_ += '      - name: ' + remote.name \
                                + '\n        url: ' + remote.url + '\n'
                        str_ += '\n'

                    yaml.write(str_)

                personal_repos = list(filter(lambda x: 'zfa_' in x.working_dir, self.repos))
                if len(personal_repos):
                    yaml.write('groups:\n')
                    yaml.write('  perso:\n')
                    yaml.write('    repos: ')
                    yaml.write(str(list(map(lambda x: x.working_dir, personal_repos))))

    def save():
        # use pickle to save self
        pass

    def __str__(self):
        str_ = 'Repos in cluster:\n'
        if self.repos:
            for repo in self.repos:
                str_ += (repo.working_dir)
                str_ += '\n'

        return str_

# Set the directory you want to start from


def main(argv):
    parser = argparse.ArgumentParser(description="")
    parser.add_argument("--root-dirs", "-r",
                        dest='root_dirs',
                        nargs='+',
                        type=str,
                        required=True,
                        default='.')
    parser.add_argument("--manifest-dir", "-o",
                        dest='manifest_dir',
                        type=str,
                        required=True,
                        default='.')
    args = parser.parse_args()
    args.root_dirs = list(map(path.abspath, args.root_dirs))
    args.manifest_dir = path.abspath(args.manifest_dir)

    cluster = ReposCluster()
    cluster.inhale_repos(args.root_dirs)
    cluster.write_manifest(args.root_dirs, args.manifest_dir)


if __name__ == '__main__':
    main(sys.argv)
