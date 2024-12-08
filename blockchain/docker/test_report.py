#!/usr/bin/env python3

import subprocess
import json
import sys
import os
from datetime import datetime
import time

class TestReport:
    def __init__(self):
        self.results = {
            'timestamp': datetime.now().isoformat(),
            'tests': [],
            'summary': {
                'total': 0,
                'passed': 0,
                'failed': 0
            }
        }
    
    def add_result(self, name, status, details):
        self.results['tests'].append({
            'name': name,
            'status': status,
            'details': details,
            'timestamp': datetime.now().isoformat()
        })
        self.results['summary']['total'] += 1
        if status == 'PASS':
            self.results['summary']['passed'] += 1
        else:
            self.results['summary']['failed'] += 1
    
    def exec_command(self, node, command):
        try:
            result = subprocess.run(
                f'docker-compose exec -T node{node} saudichain-cli -testnet {command}',
                shell=True,
                capture_output=True,
                text=True
            )
            return result.stdout.strip()
        except Exception as e:
            return str(e)
    
    def run_network_tests(self):
        # Test 1: Node Connectivity
        for node in range(1, 4):
            conn_count = self.exec_command(node, 'getconnectioncount')
            try:
                if int(conn_count) > 0:
                    self.add_result(
                        f'Node {node} Connectivity',
                        'PASS',
                        f'Connected to {conn_count} peers'
                    )
                else:
                    self.add_result(
                        f'Node {node} Connectivity',
                        'FAIL',
                        'No connections'
                    )
            except:
                self.add_result(
                    f'Node {node} Connectivity',
                    'FAIL',
                    f'Error: {conn_count}'
                )
        
        # Test 2: Block Synchronization
        heights = []
        for node in range(1, 4):
            height = self.exec_command(node, 'getblockcount')
            heights.append(height)
        
        if len(set(heights)) == 1 and heights[0].isdigit():
            self.add_result(
                'Block Synchronization',
                'PASS',
                f'All nodes at height {heights[0]}'
            )
        else:
            self.add_result(
                'Block Synchronization',
                'FAIL',
                f'Height mismatch: {heights}'
            )
        
        # Test 3: Staking Status
        for node in range(1, 4):
            stake_info = self.exec_command(node, 'getstakinginfo')
            try:
                stake_data = json.loads(stake_info)
                if stake_data.get('enabled', False):
                    self.add_result(
                        f'Node {node} Staking',
                        'PASS',
                        f'Staking enabled, weight: {stake_data.get("weight", 0)}'
                    )
                else:
                    self.add_result(
                        f'Node {node} Staking',
                        'FAIL',
                        'Staking not enabled'
                    )
            except:
                self.add_result(
                    f'Node {node} Staking',
                    'FAIL',
                    f'Error parsing staking info: {stake_info}'
                )
    
    def save_report(self):
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        filename = f'test_report_{timestamp}.json'
        
        # Calculate success rate
        total = self.results['summary']['total']
        passed = self.results['summary']['passed']
        self.results['summary']['success_rate'] = f'{(passed/total*100):.2f}%' if total > 0 else '0%'
        
        with open(filename, 'w') as f:
            json.dump(self.results, f, indent=2)
        return filename

def main():
    report = TestReport()
    print('Starting network tests...')
    report.run_network_tests()
    filename = report.save_report()
    print(f'\nTest Report saved to: {filename}')
    
    # Print summary
    summary = report.results['summary']
    print(f'\nTest Summary:')
    print(f'Total Tests: {summary["total"]}')
    print(f'Passed: {summary["passed"]}')
    print(f'Failed: {summary["failed"]}')
    print(f'Success Rate: {summary["success_rate"]}')
    
    return 0 if summary['failed'] == 0 else 1

if __name__ == '__main__':
    sys.exit(main())
